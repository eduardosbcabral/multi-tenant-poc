#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["MultiTenant.Api/MultiTenant.Api.csproj", "MultiTenant.Api/"]
RUN dotnet restore "MultiTenant.Api/MultiTenant.Api.csproj"
COPY . .
WORKDIR "/src/MultiTenant.Api"
RUN dotnet build "MultiTenant.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "MultiTenant.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MultiTenant.Api.dll"]