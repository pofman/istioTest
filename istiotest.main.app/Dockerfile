FROM mcr.microsoft.com/dotnet/sdk:5.0.103-buster-slim-amd64 AS base

WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["istiotest.main.app.csproj", "."]
RUN dotnet restore "istiotest.main.app.csproj"
COPY . .
RUN dotnet build "istiotest.main.app.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "istiotest.main.app.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "istiotest.main.app.dll", "--urls", "http://*:80"]