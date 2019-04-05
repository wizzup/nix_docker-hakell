set -x
set -e

DOCKER_PS=$(docker ps -qa)
DOCKER_IMGS=$(docker images -qa)

##-- docker cleanup --
docker system prune -af
[[ -n "$DOCKER_PS" ]] && docker kill "$DOCKER_PS"
[[ -n "$DOCKER_IMGS" ]] && docker image rm -f "$DOCKER_IMGS"

##-- build and loading --
nix-build
du -h $(readlink -f result)
docker load < result

##-- testing --
docker run --rm hs-stack
docker run -it --rm hs-stack bash
