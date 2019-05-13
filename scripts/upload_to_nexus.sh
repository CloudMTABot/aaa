@Library(['piper-lib', 'piper-lib-os']) _

try {
    stage("Run Voter") {
        node {
          mkdir tempDir
          cd tempDir
          wget https://github.com/michawai/aaa/edit/develop/VERSION
          ls -la
          MBT_VERSION=$(cat ./VERSION)
          echo $MBT_VERSION
          curl -L https://github.com/SAP/cloud-mta-build-tool/releases/download/v${MBT_VERSION}/cloud-mta-build-tool_${MBT_VERSION}_Darwin_amd64.tar.gz -o cloud-mta-build-tool_${MBT_VERSION}_Darwin_amd64.tar.gz
          curl -L https://github.com/SAP/cloud-mta-build-tool/releases/download/v${MBT_VERSION}/cloud-mta-build-tool_${MBT_VERSION}_Linux_amd64.tar.gz -o cloud-mta-build-tool_${MBT_VERSION}_Linux_amd64.tar.gz
          curl -L https://github.com/SAP/cloud-mta-build-tool/releases/download/v${MBT_VERSION}/cloud-mta-build-tool_${MBT_VERSION}_Windows_amd64.tar.gz -o cloud-mta-build-tool_${MBT_VERSION}_Windows_amd64.tar.gz
          artifactdeployer pack --script-file configpack --package-file cloud-mta-build-tool-pack -D mbtVersion=$MBT_VERSION
          artifactdeployer deploy --package-file cloud-mta-build-tool-pack --artifact-version $MBT_VERSION --repo-url http://nexusmil.wdf.sap.corp:8081/nexus/content/repositories/sap.milestones.manual-uploads.hosted --repo-user $MVN_REPO_USER --repo-passwd $MVN_REPO_PASSWD
        }
    }
} catch(Exception error) {
    mail body: """The upload to nexust of MBT is failing and requires your attention.
    Regards,
    FMS JaaS Server""".stripIndent().trim(), subject: 'MBT upload to nexus process has failed!', to: 'michal.tall@sap.com'
    throw error;
}
