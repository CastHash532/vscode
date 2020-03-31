# VsCode by Casthash532

`casthash532/vscode` is [VS Code](https://github.com/Microsoft/vscode) IDE running on a remote server.
Try it out:

```bash
docker run --privileged \
            -p 127.0.0.1:8080:8080 \
            -v "$PWD:/home/coder/project" \
            -it casthash532/vscode
```


- **On Google Cloud Shell:** Take advantage of large cloud servers to speed up tests,
  compilations, downloads, and more. Preserve battery life when you're on the go
  since all intensive computation runs on your [Google Cloud Shell](https://console.cloud.google.com/) instance.



