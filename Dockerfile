ARG UNITY_VERSION="2021.3.3f1c1"
ARG IMAGE="unityci/editor"
ARG IMAGE_VERSION="1.0.1"

FROM $IMAGE:$UNITY_VERSION-base-$IMAGE_VERSION

# Add mono to sources
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list

# Install .NET SDK & Mono
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && rm packages-microsoft-prod.deb
RUN apt-get update \
  && apt-get install -y apt-transport-https \
  dotnet-sdk-6.0 \
  mono-devel \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN export FrameworkPathOverride=/opt/unity/Editor/Data/MonoBleedingEdge/