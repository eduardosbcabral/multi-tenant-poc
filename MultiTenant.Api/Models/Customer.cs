namespace MultiTenant.Api.Models;

public class Customer
{
    public Guid Id { get; set; }
	public string Domain { get; set; }
	public string Schema { get; set; }

    public Customer() { }
}
