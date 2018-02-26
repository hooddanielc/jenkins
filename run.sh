DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
docker stack deploy --compose-file docker-stack.yml havenofcode-jenkins
