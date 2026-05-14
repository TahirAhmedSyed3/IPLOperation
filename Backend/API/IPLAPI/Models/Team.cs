using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace IPLAPI.Models
{
    [Table("teams")]
    public class Team
    {
        [Key]
        [Column("team_id")]
        public short TeamId { get; set; }

        [Column("official_name")]
        public string OfficialName { get; set; }

        [Column("short_name")]
        public string ShortName { get; set; }

        [Column("city")]
        public string City { get; set; }

        public ICollection<SeasonTeam> SeasonTeams { get; set; }
        public ICollection<Season> WonSeasons { get; set; }
    }
}