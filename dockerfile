# Base stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base
WORKDIR /src

# Build stage
FROM base AS build
COPY ["PDVreact.csproj", "./"]
RUN dotnet restore "PDVreact.csproj"
COPY . .
WORKDIR "/src/ClientApp"
RUN apt-get update && apt-get install -y nodejs
RUN npm install -g npm
RUN npm install
RUN npm run build
WORKDIR "/src/."
RUN dotnet build "PDVreact.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
COPY --from=build /app/build .
RUN dotnet publish "PDVreact.csproj" -c Release -o /app/publish

# Final stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
RUN npm install --production
ENTRYPOINT ["dotnet", "PDVreact.dll"]
