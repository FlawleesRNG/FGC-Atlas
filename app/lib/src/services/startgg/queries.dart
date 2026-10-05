class StartGGQueries {
  const StartGGQueries._();

  static const eventEntrantsBySlug = '''
query EventEntrantsBySlug(
  \$eventSlug: String!
  \$page: Int!
  \$perPage: Int!
) {
  event(slug: \$eventSlug) {
    entrants(query: {page: \$page, perPage: \$perPage}) {
      nodes {
        id
        name
        seeds {
          seedNum
        }
        participants {
          id
          gamerTag
          prefix
          player {
            id
            gamerTag
          }
          user {
            id
            slug
            discriminator
          }
        }
      }
    }
  }
}
''';

  static const tournamentBySlug = '''
query TournamentBySlug(\$slug: String!) {
  tournament(slug: \$slug) {
    id
    name
    slug
    startAt
    events {
      id
      name
      slug
      numEntrants
      videogame {
        id
        name
        displayName
        slug
      }
    }
    participants(query: {perPage: 1, page: 1}) {
      pageInfo {
        total
      }
    }
  }
}
''';

  static const eventBySlug = '''
query EventBySlug(\$slug: String!) {
  event(slug: \$slug) {
    id
    name
    slug
    numEntrants
    videogame {
      id
      name
      displayName
      slug
    }
  }
}
''';
}
