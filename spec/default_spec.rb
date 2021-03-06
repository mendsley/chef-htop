require "spec_helper"

describe "htop::default" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  context "in a redhat-based platform" do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: "redhat", version: "6.3")
        .converge(described_recipe)
    end

    it "includes the yum::repoforge recipe" do
      expect(chef_run).to include_recipe("yum-repoforge")
    end

  end

  it "installs the package" do
    expect(chef_run).to install_package("htop")
  end

  context "when a version is specified" do
    it "installs the specific version of the package" do
      chef_run.node.set["htop"]["version"] = "1.2.3"
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package("htop").with(version: "1.2.3")
    end
  end
end
