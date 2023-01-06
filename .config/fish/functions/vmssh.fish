# eg:
# alias dev1="vmssh dev1 bd366039-c9d2-4416-9c59-5d63f7524891"
function vmssh --description "SSH into a VM, starting it if necessary"
  set -l host $argv[1]
  set -l uuid $argv[2]

  if vboxmanage list runningvms | grep $uuid
  else
    vboxmanage startvm $host --type headless
    while ! ssh $host /bin/true
      sleep 1
    end
  end
  ssh $host
end
