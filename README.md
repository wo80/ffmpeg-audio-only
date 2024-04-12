# ffmpeg-audio-only

A Github workflow for FFmpeg producing build artifacts and releases for MSVC (both shared and static libraries are avialable). The source code is downloaded from https://ffmpeg.org/releases/ and compiled without modifications. The workflow is configured to build audio-only FFmpeg features, see [common.sh](https://github.com/wo80/ffmpeg-audio-only/blob/develop/common.sh).

Based on https://github.com/acoustid/ffmpeg-build (build scripts are licensed under MIT, see [LICENSE](https://github.com/acoustid/ffmpeg-build/blob/main/LICENSE)).

## License

The released FFmpeg binaries are licensed under LGPL v2.1+, see [LICENSE.md](https://github.com/FFmpeg/FFmpeg/blob/master/LICENSE.md) and [COPYING.LGPLv2.1](https://github.com/FFmpeg/FFmpeg/blob/master/COPYING.LGPLv2.1).

## Contributing

The `main` branch is used for releases only and is protected against direct pushes. If you'd like to contribute, use the `develop` branch to make pull requests.
