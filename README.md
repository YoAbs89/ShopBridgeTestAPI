# ShopBridgeTestAPI

This is a test web API created for Checking Inventory details.

Following are the operations done here:
1. GET Request - Fetch the full inevtory details
2. POST Request - Create a new product in the inventory
3. PUT Request - Modify an existing product in the inventory
4. DELETE Request - Remove a product from an existing brand available in the inventory

The whole API is constructed ASP.NET Core 5 with the Swagger UI.

Data Feed are fetched and the data manipulation operations are done via stored procedures using MS SQL Server 2018.

Models are created using Reverse Migration technique or Scaffolding technique to create DB models.

View Models are manually creaeed based on the requirements set by the user.

C# is the coding language used in creating this Web API.

Attached with this project is a ShopBridge.json file which contains information about API's schema.

In order to run the API, you would required DB Connection String, modify View Models and Scaffold the DB components you would need.

Controllers can be modified according to the requirements.
