using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace IPLAPI.Models
{
    [Table("seasons")]
    public class Season
    {
        [Key]
        [Column("season_id")]
        public int SeasonId { get; set; }

        [Column("season_year")]
        public short SeasonYear { get; set; }

        [Column("winner_team_id")]
        public short WinnerTeamId { get; set; }

        [Column("runner_up_team_id")]
        public short? RunnerUpTeamId { get; set; }

        public Team WinnerTeam { get; set; }
        public Team RunnerUpTeam { get; set; }

        public ICollection<SeasonTeam> SeasonTeams { get; set; }
    }
}