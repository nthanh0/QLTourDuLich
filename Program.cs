using QLTourDuLich.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// Register Oracle database services
builder.Services.AddScoped<OracleDbService>();
builder.Services.AddScoped<TourService>();
builder.Services.AddScoped<CustomerService>();
builder.Services.AddScoped<BookingService>();
builder.Services.AddScoped<EmployeeService>();
builder.Services.AddScoped<TourScheduleService>();
builder.Services.AddScoped<LocationService>();
builder.Services.AddScoped<ServiceManagementService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
