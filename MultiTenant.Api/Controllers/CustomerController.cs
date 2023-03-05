using Dapper;
using Microsoft.AspNetCore.Mvc;
using MultiTenant.Api.Models;
using System.Data;

namespace MultiTenant.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class CustomerController : ControllerBase
{
    private readonly IDbConnection _dbConnection;

    public CustomerController(IDbConnection dbConnection)
    {
        _dbConnection = dbConnection;
    }

    [HttpGet]
    public async Task<IEnumerable<Customer>> Get()
    {
        var customers = await _dbConnection.QueryAsync<Customer>("SELECT * FROM Customers");
        return customers;
    }

    [HttpGet("tenant")]
    public async Task<Customer> Tenant()
    {
        var tenant = HttpContext.Items["Tenant"]?.ToString();
        var customer = await _dbConnection.QueryFirstOrDefaultAsync<Customer>($"SELECT * FROM Customers WHERE Domain = @domain", new { Domain = tenant });
        return customer ?? new Customer()
        {
            Id = Guid.Empty,
            Domain = "default-domain"
        };
    }
}