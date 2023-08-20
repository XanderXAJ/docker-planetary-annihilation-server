# Planetary Annihilation Dedicated Server Container Image

A rootless container/Docker image for running the Planetary Annihilation: Titans dedicated server.

## Server installation

As the server required a PAnet login, this image does not container the server itself.
Instead, it contains [`papatcher`][papatcher] which logs in to PAnet using your credentials and downloads the server.

To save time and bandwidth downloading the server, a volume can be mounted at `/opt/pa` to re-use across invocations.

Note: The [`papatcher`][papatcher] in use here is forked from the official version to allow flexible rootless setups.
[See its README for details][papatcher].

[papatcher]: https://github.com/XanderXAJ/papatcher

## Usage

1. Clone this repo.
2. Create a `.env` file with your configuration, e.g.:

    ```shell
    PA_USERNAME=YourUsername
    PA_PASSWORD=YourPassword
    SERVER_PASSWORD=Ex4mple!
    ```

    You can copy [`example.env`](/example.env) and modify it as desired:

    ```shell
    cp example.env .env
    ```
3. Run the Docker Compose stack:

    ```shell
    docker compose up -d
    ```

By default, a volume is mapped to `./pa` to act as long-term storage, speeding up repeated runs of the server and retaining replays.

### UPnP

If you need to open the server port on your router, you can use the provided [`upnp.sh`](/upnp.sh) to automatically open it using [MiniUPnPc].

[miniupnpc]: https://github.com/XanderXAJ/docker-miniupnpc

## Volumes

The mountable directories inside the image are world-writable to allow rootless usage, e.g. `--user 1000:1000`.
Your directories on the host do **not** need to be world-writable -- merely writable by the user/group that you choose.

- `/opt/pa`: Contains the `papatcher` cache, downloaded server and its replays/logs

## Security

The image is automatically rebuilt every day to ensure the latest versions of MiniUPnPc and the base image are pulled in.

The images are signed using [Cosign][cosign] and the [Fulcio public CA][fulcio].
The images can be verified by running:

```shell
cosign verify --certificate-oidc-issuer 'https://token.actions.githubusercontent.com' --certificate-identity-regexp 'https://github.com/XanderXAJ/docker-planetary-annihilation-server/.+@refs/heads/main' xanderxaj/planetary-annihilation-server
cosign verify --certificate-oidc-issuer 'https://token.actions.githubusercontent.com' --certificate-identity-regexp 'https://github.com/XanderXAJ/docker-planetary-annihilation-server/.+@refs/heads/main' ghcr.io/xanderxaj/planetary-annihilation-server
```

[cosign]: https://github.com/sigstore/cosign
[fulcio]: https://github.com/sigstore/fulcio

## Development

Build the image using Docker Compose:

```shell
docker compose up --build
```
