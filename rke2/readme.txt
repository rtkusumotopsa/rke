Criando o cluster rtk2, com ingress nginx

- Criando o primeiro nó (server)

Foi seguido o tutorial na própria documentação oficial
	https://docs.rke2.io/install/quickstart/
	https://docs.rke2.io/install/ha/

Pré-requisito
É necessário acrescentar no sysctl os seguintes parametros
	net.ipv4.conf.all.forwarding       = 1
	net.ipv6.conf.all.forwarding       = 1

1 - executar o installer
	curl -sfL https://get.rke2.io | sh -
2 - habilitar o serviço
	systemctl enable rke2-server.service
2.1 - criar o arquivo /etc/rancher/rke2/config.yaml com o conteudo abaixo

	token: my-shared-secret
	tls-san:
	  - my-kubernetes-domain.com
	  - another-kubernetes-domain.com

	* onde o my-shared-secret é uma chave personalizada, pode ser criada a gosto. Eu particularmente, usei o md5 para 
	  gerar a chave
	* o tls-san: deve ser um nome de domínio usando um balanceador, que pode ser um "Round-robin DNS" ou balanceador 
	  tcp layer 4.

3 - inicialializar o serviço
	systemctl start rke2-server.service
4 - Caso haja interesse em acompanhar o progresso
	journalctl -u rke2-server -f
	Obs: O comando para iniciar o serviço retem o prompt até o término do processo de instalação.


Ferramentas adicionais ficam instalados em /var/lib/rancher/rke2/bin/. 

Eles incluem: kubectl, crictl, and ctr.

* Nota: esse caminho não é inserido no path para busca de comandos, sendo necessário, se assim desejar, includir no script 
        de inicialização.

Um arquivo kubeconfig é gravado no diretório /etc/rancher/rke2/rke2.yaml.

Um token que pode ser usado para registar outro nó server ou agente será criado em /var/lib/rancher/rke2/server/node-token


********************
* Anda não testado *
********************

- Criando um nó agente

1 - Executar o installer
	curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
2 - Habilitar o serviço rke2-agent
	systemctl enable rke2-agent.service
3 - Configurar o rke2-agent
	mkdir -p /etc/rancher/rke2/
	vim /etc/rancher/rke2/config.yaml
3.1 - Conteudo do config.yaml
	server: https://<server>:9345		#server é o domínio com os ip's em load balance
	token: <token from server node>
4 - Inicializar o rke2-agent
	systemctl start rke2-agent.service
5 - Caso queira acompanhar o log do progresso
	journalctl -u rke2-agent -f
	Obs: Vale a mesma observação do item 4 da criação do nó server

Para ver se está tudo funcional, execute

	/var/lib/rancher/rke2/bin/kubectl \
	        --kubeconfig /etc/rancher/rke2/rke2.yaml get nodes


Notas

Dois scripts de limpezas serão instalados no caminho ./usr/local/bin/rke2. Eles são: rke2-killall.sh e rke2-uninstall.sh.

************************************
* IMPORTANTE IMPORTANTE IMPORTANTE *
************************************

Rotação do certifcado

Por padrão, os certificados no RKE2 expiram em 12 meses.

Se o certificado expirar ou estiver a 90 dias para expirar, os certificados são rotacionados quando o RKE2 é reiniciado.

A partir  da versão v.1.21.8+rke2r1, os certificados podem ser rotacionados manualmente. Para fazer isso, o melhor é parar o rke2-server, rotacionar o certificado, e então iniciar o processo novamente.


	systemctl stop rke2-server
	rke2 certificate rotate
	systemctl start rke2-server


É também possível rotacionar um serviço individual passando a flag --service, por exemplo:rke2 certificate rotate --service api-server. Veja os subcomandos de certificados para maiores detalhes.
