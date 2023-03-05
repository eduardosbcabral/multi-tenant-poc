using Dapper;
using Microsoft.AspNetCore.Mvc;
using MultiTenant.Api.Models;
using System.Data;
using System.Security.Cryptography.X509Certificates;

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
    public async Task<IActionResult> Get()
    {
        var tenant = HttpContext.Items["Tenant"]?.ToString();
        var customer = await _dbConnection.QueryFirstOrDefaultAsync<Customer>($"SELECT * FROM Customers WHERE Domain = @domain", new { Domain = tenant });

        if(customer == null)
        {
            return NotFound("Customer tenant by domain not found. Check if your used domain is the right one.");
        }

        var configuration = await _dbConnection.QueryFirstOrDefaultAsync<Configuration>($"SELECT * FROM {customer.Schema}.Config");

        if(configuration == null)
        {
            return NotFound("Configuration tenant by domain not found.");
        }

        return Ok(configuration);
    }
}