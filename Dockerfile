ARG UNITY_VERSION="2021.3.3f1c1"
ARG IMAGE="unityci/editor"
ARG IMAGE_VERSION="1.0.1"

FROM $IMAGE:$UNITY_VERSION-base-$IMAGE_VERSION

RUN apt-get update && apt-get install -y apt-transport-https \
  ca-certificates \
  gnupg \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Add mono to sources
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list

# Install .NET SDK & Mono
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && rm packages-microsoft-prod.deb
RUN apt-get update \
  && apt-get install -y dotnet-sdk-6.0 \
  mono-devel \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN export FrameworkPathOverride=/opt/unity/Editor/Data/MonoBleedingEdge/

# Add generate solution script & make it executable
COPY generate_solution.sh /bin/
RUN chmod +x /bin/generate_solution.sh
