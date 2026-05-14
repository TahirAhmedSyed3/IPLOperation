using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace IPLAPI.Models
{
    [Table("season_teams")]
    public class SeasonTeam
    {
        [Key]
        [Column("season_team_id")]
        public int SeasonTeamId { get; set; }

        [Column("season_id")]
        public int SeasonId { get; set; }

        [Column("team_id")]
        public short TeamId { get; set; }

        [Column("matches_played")]
        public short MatchesPlayed { get; set; }

        [Column("points")]
        public short Points { get; set; }

        [Column("position")]
        public byte Position { get; set; }

        [Column("qualified_for_playoffs")]
        public bool QualifiedForPlayoffs { get; set; }

        public Season Season { get; set; }
        public Team Team { get; set; }
    }
}