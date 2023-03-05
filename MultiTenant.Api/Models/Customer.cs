namespace MultiTenant.Api.Models;

public class Customer
{
    public Guid Id { get; set; }
	public string Domain { get; set; }

	public Customer() { }
}
