using MultiTenant.Api.Middlewares;
using Npgsql;
using System.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

var services = builder.Services;

var connectionString = builder.Configuration.GetConnectionString("Postgres");

services.AddSingleton<IDbConnection>(new NpgsqlConnection(connectionString));

services.AddControllers();

var app = builder.Build();

app.UseMiddleware<TenantMiddleware>();

// Configure the HTTP request pipeline.

app.UseAuthorization();

app.MapControllers();

app.Run();
