# swift-arr-custom-notification

> no longer what i use in production because binary produced is huge and it's a bit of a pain to maintain & build

- Built in Swift 6.1
- Compiled against Static Linux SDK via Docker container

```bash
docker run -it --name arrbuilder -v "$PWD:/code" -w /code --platform linux/amd64 swift:latest /bin/bash
docker exec -it arrbuilder /bin/bash
```

```bash
swift sdk install
swift build -c release --swift-sdk x86_64-swift-linux-musl
strip
```
