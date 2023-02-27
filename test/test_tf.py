import pytest
import tftest
from pathlib import Path


@pytest.fixture
def plan():
    file_path = Path(__file__).resolve()
    base_dir = file_path.parent.parent.absolute()
    tf = tftest.TerraformTest(tfdir="development_rg", basedir=base_dir)
    tf.setup()
    return tf.plan(output=True)


def test_outputs_tags(plan):
    """
    Test to check the resource group has the appropriate tags
    """
    assert sorted(plan.outputs['rg_tags'].keys()) == sorted([ "CostCenter", "Owner", "User", "Enviornment"])
