namespace PDVreact.DTOs
{
    public class ReporteDTO
    {
        public int Id { get; set; }
        public DateTime FechaInicio { get; set; }
        public DateTime FechaFin { get; set; }
        public int TotalVentas { get; set; }
        public decimal IngresosTotales { get; set; }
        public decimal PromedioVentas { get; set; }
        public List<VentaDTO> Ventas { get; set; }
    }
}
