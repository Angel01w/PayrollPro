using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Nominas.DB;
using Nominas.Models;
using System.Security.Claims;

namespace Nominas.Controllers
{
    public class LoginController : Controller
    {
        private readonly AplicationDBContext _context;

        public LoginController(AplicationDBContext context)
        {
            _context = context;
        }
        public IActionResult Home()
        {
            return View();
        }
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]

        public IActionResult Home(string Correo, string Contrasena)
        {
            if (Contrasena == null || Correo == null)
            {
                ViewBag.Error = "Campos vacios";

            }
            Usuario? usuario = new Usuario();

            usuario = _context.usuario.Where(x => x.Correo == Correo && x.contrasena == Contrasena).FirstOrDefault();

            if (usuario == null)
            {
                ViewBag.Error = "Correo o contraseña no correcta";
                return View();
            }
            var claims = new List<Claim>
            {
            new Claim(ClaimTypes.Email, usuario.Correo),
            // Agrega más claims si es necesario
            };

            var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            var authProperties = new AuthenticationProperties
            {
                // Configurar propiedades adicionales de autenticación si es necesario
            };


            if (usuario.EsAdministrador == true)
            {
                return RedirectToAction("HomeAdmin", "Home");
            }
            else
            {
                return RedirectToAction("HomeEmpleado", "Home");
            }

        }

    }
}
