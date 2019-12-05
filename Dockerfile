FROM mcr.microsoft.com/dotnet/core/runtime:2.2 AS build

RUN ls
COPY /myweb/ app/
RUN dotnet restore
RUN dotnet build -c Release --no-restore

FROM build AS publish
RUN dotnet publish /src/Api/Api.csproj -c Release -o /app --no-restore

FROM microsoft/dotnet:2.2-aspnetcore-runtime
COPY --from=publish /app .
ENTRYPOINT [ "dotnet", "Api.dll"]