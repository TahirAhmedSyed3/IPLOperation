using IPLAPI.Models;
using Microsoft.EntityFrameworkCore;

namespace IPLAPI.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions options) : base(options)
        {
        }

        public DbSet<Team> Teams { get; set; }
        public DbSet<Season> Seasons { get; set; }
        public DbSet<SeasonTeam> SeasonTeams { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Season → Winner Team (Many Seasons → One Team)
            modelBuilder.Entity<Season>()
                .HasOne(s => s.WinnerTeam)
                .WithMany(t => t.WonSeasons)
                .HasForeignKey(s => s.WinnerTeamId)
                .OnDelete(DeleteBehavior.Restrict);

            // Season → Runner-up Team
            modelBuilder.Entity<Season>()
                .HasOne(s => s.RunnerUpTeam)
                .WithMany()
                .HasForeignKey(s => s.RunnerUpTeamId)
                .OnDelete(DeleteBehavior.Restrict);

            // Season ↔ Team (Many-to-Many via SeasonTeams)
            modelBuilder.Entity<SeasonTeam>()
                .HasOne(st => st.Team)
                .WithMany(t => t.SeasonTeams)
                .HasForeignKey(st => st.TeamId);

            modelBuilder.Entity<SeasonTeam>()
                .HasOne(st => st.Season)
                .WithMany(s => s.SeasonTeams)
                .HasForeignKey(st => st.SeasonId);

            modelBuilder.Entity<SeasonTeam>()
                .HasIndex(st => new { st.SeasonId, st.TeamId })
                .IsUnique();
        }
    }
}
