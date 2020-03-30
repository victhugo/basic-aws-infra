resource "aws_key_pair" "vhugo-key" {
  key_name = "vhugo.godinez"
  public_key = file("~/.ssh/id_rsa.pub")
}