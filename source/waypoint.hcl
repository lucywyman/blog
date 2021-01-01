project = "Simple static website deployment"

app "Blog" {
  labels = { 
    "service" = "blog",
    "env" = "prod"
  }

  build {
    use "bolt" {
      plan = "blog::build"
      targets = ["localhost"]
      project = "/home/lucy/githubs/websites/blog/source/bolt"
    }   
  }

  deploy { 
    use "bolt" {
      plan = "blog::deploy"
      targets = ["terraform"]
      project = "/home/lucy/githubs/websites/blog/source/bolt"
      flags = ["uri=blog-demo.lucywyman.me", "source_path=/home/lucy/githubs/websites/blog/source/output", "--run-as root"]
    }   
  }
}
