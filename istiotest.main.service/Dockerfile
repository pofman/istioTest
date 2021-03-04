FROM mcr.microsoft.com/dotnet/sdk:5.0.103-buster-slim-amd64 AS base

WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["istiotest.main.service.csproj", "."]
RUN dotnet restore "istiotest.main.service.csproj"
COPY . .
RUN dotnet build "istiotest.main.service.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "istiotest.main.service.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "istiotest.main.service.dll", "--urls", "http://*:80"]