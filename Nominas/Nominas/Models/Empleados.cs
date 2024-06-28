using System.ComponentModel.DataAnnotations;

namespace Nominas.Models
{
    public class Empleados
    {
        [Key]
        public int id { get; set; }
        public string? Cedula { get; set; }
        public string? Nombre { get; set; }
        public int id_Departamento { get; set; }
        public int id_puesto { get; set; }
        public decimal Salario { get; set; }
        public int id_tipo_ingreso { get; set; }
    }
}
