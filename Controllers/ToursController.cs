using Microsoft.AspNetCore.Mvc;
using QLTourDuLich.Models;
using QLTourDuLich.Services;

namespace QLTourDuLich.Controllers
{
    public class ToursController : Controller
    {
        private readonly TourService _tourService;
        private readonly EmployeeService _employeeService;

        public ToursController(TourService tourService, EmployeeService employeeService)
        {
            _tourService = tourService;
            _employeeService = employeeService;
        }

        // GET: Tours
        public async Task<IActionResult> Index()
        {
            var tours = await _tourService.GetAllToursAsync();
            return View(tours);
        }

        // GET: Tours/Details/5
        public async Task<IActionResult> Details(int id)
        {
            var tour = await _tourService.GetTourByIdAsync(id);
            if (tour == null)
            {
                return NotFound();
            }
            
            // L?y thêm thông tin doanh thu t? function
            ViewBag.Revenue = await _tourService.GetTourRevenueAsync(id);
            
            return View(tour);
        }

        // GET: Tours/Create
        public async Task<IActionResult> Create()
        {
            ViewBag.Employees = await _employeeService.GetAllEmployeesAsync();
            return View();
        }

        // POST: Tours/Create - S? D?NG SP_CreateTour
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Tour tour)
        {
            if (ModelState.IsValid)
            {
                var (tourId, message) = await _tourService.CreateTourAsync(tour);
                
                if (tourId > 0)
                {
                    TempData["SuccessMessage"] = message;
                    return RedirectToAction(nameof(Index));
                }
                else
                {
                    TempData["ErrorMessage"] = message;
                }
            }
            ViewBag.Employees = await _employeeService.GetAllEmployeesAsync();
            return View(tour);
        }

        // GET: Tours/Edit/5
        public async Task<IActionResult> Edit(int id)
        {
            var tour = await _tourService.GetTourByIdAsync(id);
            if (tour == null)
            {
                return NotFound();
            }
            ViewBag.Employees = await _employeeService.GetAllEmployeesAsync();
            return View(tour);
        }

        // POST: Tours/Edit/5 - S? D?NG SP_UpdateTour
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Tour tour)
        {
            if (id != tour.TourId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                var (success, message) = await _tourService.UpdateTourAsync(tour);
                
                if (success == 1)
                {
                    TempData["SuccessMessage"] = message;
                    return RedirectToAction(nameof(Index));
                }
                else
                {
                    TempData["ErrorMessage"] = message;
                }
            }
            ViewBag.Employees = await _employeeService.GetAllEmployeesAsync();
            return View(tour);
        }

        // GET: Tours/Delete/5
        public async Task<IActionResult> Delete(int id)
        {
            var tour = await _tourService.GetTourByIdAsync(id);
            if (tour == null)
            {
                return NotFound();
            }
            return View(tour);
        }

        // POST: Tours/Delete/5 - S? D?NG SP_DeleteTour
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var (success, message) = await _tourService.DeleteTourAsync(id);
            
            if (success == 1)
            {
                TempData["SuccessMessage"] = message;
            }
            else
            {
                TempData["ErrorMessage"] = message;
            }
            
            return RedirectToAction(nameof(Index));
        }
    }
}
