# Docker image for Unity code quality in CI

(Not affiliated with Unity Technologies)

This docker image is based on [unityci/editor](https://github.com/game-ci/docker).

The purpose is to have .NET SDK to run dotnet commands in a Unity environment such as : `dotnet format` command to get code quality results as a report for Merge Requests Widget on GitLab.