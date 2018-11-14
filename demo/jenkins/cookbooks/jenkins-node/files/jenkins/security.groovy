#!groovy

import jenkins.model.*
import jenkins.model.Jenkins
import jenkins.model.JenkinsLocationConfiguration
import hudson.security.*
import hudson.security.csrf.DefaultCrumbIssuer
import jenkins.security.s2m.AdminWhitelistRule

def instance = Jenkins.getInstance()
def location = instance.getExtensionList('jenkins.model.JenkinsLocationConfiguration')[0]

location.adminAddress = 'nobody@nobody.com'

def user = new File("/run/secrets/jenkins-user").text.trim()
def pass = new File("/run/secrets/jenkins-pass").text.trim()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(user, pass)
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
instance.setCrumbIssuer(new DefaultCrumbIssuer(true))
instance.save()

Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)

jenkins.model.Jenkins.instance.getDescriptor("jenkins.CLI").get().setEnabled(false)

/*
   Disable all JNLP protocols except for JNLP4.  JNLP4 is the most secure agent
   protocol because it is using standard TLS.
*/
Jenkins j = Jenkins.instance

if(!j.isQuietingDown()) {
    Set<String> agentProtocolsList = ['JNLP4-connect', 'Ping']
    if(!j.getAgentProtocols().equals(agentProtocolsList)) {
        j.setAgentProtocols(agentProtocolsList)
        println "Agent Protocols have changed.  Setting: ${agentProtocolsList}"
        j.save()
    }
    else {
        println "Nothing changed.  Agent Protocols already configured: ${j.getAgentProtocols()}"
    }
}
else {
    println 'Shutdown mode enabled.  Configure Agent Protocols SKIPPED.'
}