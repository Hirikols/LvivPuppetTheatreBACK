FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 5000

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY . .
RUN dotnet restore "Web/Web.csproj"
WORKDIR /src/Web/
RUN dotnet ef migrations add InitialCreate
RUN dotnet ef database update InitialCreate
RUN dotnet build "Web.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "Web.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
RUN mkdir AudioFiles
COPY ./Web/AudioFiles ./AudioFiles
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Web.dll"]

