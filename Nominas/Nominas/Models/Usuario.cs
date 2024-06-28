namespace Nominas.Models
{
    public class Usuario
    {
        public int idusuario { get; set; }
        public string? Cedula { get; set; }
        public string? Correo { get; set; }
        public string? contrasena { get; set; }
        public bool EsAdministrador { get; set; }
        public bool Activo { get; set; }
        public DateTime FechaRegistro { get; set; }
    }
}
