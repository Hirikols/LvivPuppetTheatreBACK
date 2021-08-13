using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using SoftServe.ITAcademy.BackendDubbingProject.Administration.Core.Interfaces;
using SoftServe.ITAcademy.BackendDubbingProject.Administration.Infrastructure.Database;
using SoftServe.ITAcademy.BackendDubbingProject.Administration.Infrastructure.FileSystem;

namespace SoftServe.ITAcademy.BackendDubbingProject.Administration.Infrastructure.Configuration
{
    public class InfrastructureServiceCollection : IInfrastructureServiceCollection
    {
        public void RegisterDependencies(IServiceCollection services)
        {
            const string connection = "Host=10.26.0.215;Database=dubbing;Username=dubbing;Password=dubbing";

            services.AddDbContext<DubbingContext>(options =>
                options.UseNpgsql(connection, b => b.MigrationsAssembly("Web")));

            services.AddScoped<DbContext, DubbingContext>();

            services.AddScoped(typeof(IRepository<>), typeof(Repository<>));

            services.AddScoped<IFileSystemRepository, FileSystemRepository>();
        }
    }
}