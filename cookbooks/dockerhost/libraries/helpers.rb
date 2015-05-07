# Returns true if the given application
# should be deployed
#
# @param name [String]
#
# @return [true, false]
#
def deploy?(name)
  return true unless node.attribute? 'opsworks'
  return true if node['deploy'].attribute? 'all'
  return true if node['deploy'].attribute? name
end
