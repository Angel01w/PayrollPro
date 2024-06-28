using Microsoft.EntityFrameworkCore;
using Nominas.Models;

namespace Nominas.DB
{
    public class AplicationDBContext:DbContext
    {
        public AplicationDBContext(DbContextOptions<AplicationDBContext> options):base(options) 
        {
            
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Usuario>()
                .HasKey(u => u.idusuario);

            // Configuración adicional...
        }
        public DbSet <Empleados> empleados { get; set; }
        public DbSet <Usuario> usuario { get; set; }
    }
}
