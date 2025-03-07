output "installer" {
  value = aws_instance.aap25-demo-installer.public_ip
}

output "automationgateway-0" {
  value = aws_instance.automationgateway-0.public_ip
}
output "automationgateway-1" {
  value = aws_instance.automationgateway-1.public_ip
}
output "automationcontroller-0" {
  value = aws_instance.automationcontroller-0.public_ip
}
output "automationcontroller-1" {
  value = aws_instance.automationcontroller-1.public_ip
}
output "automationhub-0" {
  value = aws_instance.automationhub-0.public_ip
}
output "automationhub-1" {
  value = aws_instance.automationhub-1.public_ip
}
output "automationedacontroller-0" {
  value = aws_instance.automationedacontroller-0.public_ip
}
output "automationedacontroller-1" {
  value = aws_instance.automationedacontroller-1.public_ip
}
output "executionnode-0" {
  value = aws_instance.executionnode-0.public_ip
}
output "executionnode-1" {
  value = aws_instance.executionnode-1.public_ip
}
output "database-0" {
  value = aws_instance.database-0.public_ip
}
output "client-0" {
  value = aws_instance.client-0.public_ip
}
