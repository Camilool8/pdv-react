using AutoMapper;
using PDVreact.DTOs;
using PDVreact.Models;


    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            // Usuario Mapping
            CreateMap<Usuario, UsuarioDTO>();
            CreateMap<UsuarioCreateDTO, Usuario>();

            // Cliente Mapping
            CreateMap<Cliente, ClienteDTO>();
            CreateMap<ClienteDTO, Cliente>();

        // Venta Mapping
        CreateMap<Venta, VentaDTO>()
            .ForMember(dest => dest.Cliente, opt => opt.MapFrom(src => src.Cliente))
            .ForMember(dest => dest.Usuario, opt => opt.MapFrom(src => src.Usuario))
            .ForMember(dest => dest.VentaProductos, opt => opt.MapFrom(src => src.VentaProductos))
            .ForMember(dest => dest.Pagos, opt => opt.MapFrom(src => src.Pagos))
            .ForMember(dest => dest.Factura, opt => opt.MapFrom(src => src.Factura));
        CreateMap<VentaDTO, Venta>()
            .ForMember(dest => dest.Cliente, opt => opt.Ignore())
            .ForMember(dest => dest.Usuario, opt => opt.Ignore())
            .ForMember(dest => dest.VentaProductos, opt => opt.Ignore())
            .ForMember(dest => dest.Pagos, opt => opt.Ignore())
            .ForMember(dest => dest.Factura, opt => opt.Ignore());

        // Mesa Mapping
        CreateMap<Mesa, MesaDTO>();
            CreateMap<MesaDTO, Mesa>();

            // Producto Mapping
            CreateMap<Producto, ProductoDTO>();
            CreateMap<ProductoDTO, Producto>();

            // VentaProducto Mapping
            CreateMap<VentaProducto, VentaProductoDTO>()
                .ForMember(dest => dest.VentaId, opt => opt.MapFrom(src => src.VentaId))
                .ForMember(dest => dest.ProductoId, opt => opt.MapFrom(src => src.ProductoId));
            CreateMap<VentaProductoDTO, VentaProducto>();

            // Factura Mapping
            CreateMap<Factura, FacturaDTO>()
                .ForMember(dest => dest.Ventas, opt => opt.MapFrom(src => src.Ventas));
            CreateMap<FacturaDTO, Factura>();
        }
    }

