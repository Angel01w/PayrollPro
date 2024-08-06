using Microsoft.EntityFrameworkCore;
using Nominas.DB;
using QuestPDF;
using QuestPDF.Infrastructure;

namespace Nominas
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            builder.Services.AddDbContext<AplicationDBContext>(options =>
                options.UseSqlServer(builder.Configuration.GetConnectionString("PayrollPro")));

            // Add services to the container.
            builder.Services.AddControllersWithViews();

            var app = builder.Build();

            // Configure the QuestPDF license
            QuestPDF.Settings.License = LicenseType.Community;

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
                pattern: "{controller=Login}/{action=Home}/{id?}");

            app.Run();
        }
    }
}
