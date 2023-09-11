# My Docker-VSCode Template for R (with Python, Julia, and LaTeX)

## How to use

- [Blog Post](https://kazuyanagimoto.com/blog/2023/09/06/docker_template/)
- [Zenn article (Japanese)](https://zenn.dev/nicetak/articles/vscode-docker-2023)

## Prerequisites (and for the first time to use this template)

- Install [Docker Desktop](https://www.docker.com/products/docker-desktop/). I strongly recommend using it on WSL2 (Windows Subsystem for Linux 2) if you are using Windows.
- Install [VSCode](https://code.visualstudio.com/) and [Remote-Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- Create [Docker volumes](https://docs.docker.com/storage/volumes/) by running
    ```{bash}
    docker volume create renv
    docker volume create pip
    docker volume create julia
    docker volume create TinyTeX
    docker volume create fonts
    ```

## Setup & Workflows

I will introduce the workflow when starting a project using this template and when working.
The _administrator_ creates a project using this template,
and the _collaborators_ clone the project and work on it.

### Administrator

0. Create Docker Volumes. (Only for the first time using this template)

```{.shell}
docker volume create renv
docker volume create pip
docker volume create julia
docker volume create TinyTeX
docker volume create fonts
```

1. Create a new repository from this template on GitHub and clone it to your local computer
1. Open this repository in VSCode. (Remote Containers)
1. Create an R project. If you use Rstudio, access `localhost:8787` and create a project.
1. Start package management with `renv::init()`
1. Install DVC with `pip install dvc dvc-gdrive`. This command is not required after the second time because of the pip cache
1. Set up the DVC environment
   - Create a folder on Google Drive and copy its ID
   - Run `dvc init && dvc remote add -d myremote gdrive://<Google Drive folder ID>`
   - Share the Google Drive folder with the collaborators (as a normal Google Drive folder)
1. Set up VSCode settings for LaTeX
    - For the first time, run `tinytex::install_tinytex(dir = "/home/rstudio/.TinyTeX", force = TRUE)`
    - Copy `.vscode/_settings.json` to `.vscode/settings.json`
1. Set up Julia environment. Create an empty `Project.toml` file and activate it with `Pkg.activate()`.

### Collaborators

0. Create Docker Volumes. (Only for the first time using this template)
1. Clone the repository created by the administrator on GitHub
1. Open this repository in VSCode. (Remote Containers)
1. Open the R project. (If you use Rstudio, access `localhost:8787` and open the project.)
1. Install the R packages with `renv::restore()`
1. Install Python packages (including DVC) with `pip install -r requirements.txt`
1. Download the data with `dvc pull`
1. Set up VSCode settings for LaTeX
    - For the first time, run `tinytex::install_tinytex(dir = "/home/rstudio/.TinyTeX", force = TRUE)`
    - Copy `.vscode/_settings.json` to `.vscode/settings.json`
1. Install Julia packages with `Pkg.activate(); Pkg.instantiate()`

### During Work

1. When you add an R package, record it with `renv::snapshot()`
1. When you add a Julia package, add it with `Pkg.add("Package Name")`. It will be automatically recorded in `Project.toml`
1. When you add a Python package, add it with `pip install Package Name` and record it with `pip freeze > requirements.txt`
1. When you add data with DVC, add it with `dvc add`. Usually, just add the directory with `dvc add data/`
1. After the above work, `git add`, `git commit`, and `git push`
1. When you finish the work, upload the data with `dvc push`
