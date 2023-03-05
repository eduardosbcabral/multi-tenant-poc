namespace MultiTenant.Api.Middlewares;

public class TenantMiddleware
{
    private readonly RequestDelegate _next;

    public TenantMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task Invoke(HttpContext context)
    {
        var tenant = context.Request.Host.Value.Split('.').First();
        if (tenant.Contains(':'))
        {
            tenant = tenant.Split(':').FirstOrDefault();
        }
        // TODO: lookup tenant based on subdomain, and set as a property on the HttpContext
        context.Items["Tenant"] = tenant;

        await _next(context);
    }
}
