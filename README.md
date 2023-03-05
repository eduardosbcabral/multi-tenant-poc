# multi-tenant-poc
A poc application to see how the application can handle domain based tenant using a middleware

# Usage

You need to add the entry to the hosts file to use the default saved tenant option.

```
127.0.0.1    mt-one.test
127.0.0.1    mt-two.test
```

Now you can access the application and see how the middleware checks the domain and the endpoint queries for the right tenant.
```
http://localhost:8081/customer
http://mt-one.test:8081/customer
http://mt-two.test:8081/customer
```