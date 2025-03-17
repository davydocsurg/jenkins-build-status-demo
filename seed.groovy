import jenkins.model.*
import hudson.security.*
import org.jenkinsci.plugins.github.webhook.*

def instance = Jenkins.getInstance()

// Set authorization to allow anonymous access to webhook
def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.READ, "anonymous")
strategy.add(Item.BUILD, "anonymous")
strategy.add(Item.READ, "anonymous")
instance.setAuthorizationStrategy(strategy)

// Set GitHub webhook trigger
def triggerDescriptor = instance.getDescriptor(GitHubWebHook.class)
triggerDescriptor.setManageHooks(true)

// Save settings
instance.save()
println "Jenkins security and webhook settings applied successfully!"
