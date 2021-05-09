using NUnit.Framework;
using static Jackett.Common.Utils.FilterFunc;

namespace Jackett.Test.Common.Utils.FilterFuncs
{
    [TestFixture]
    public class TypeFuncTests
    {
        private class TypeIndexerStub : IndexerStub
        {
            public TypeIndexerStub(string type)
            {
                Type = type;
            }

            public override bool IsConfigured => true;

            public override string Type { get; }
        }

        [Test]
        public void CaseInsensitiveSource_CaseInsensitiveFilter()
        {
            var typeId = "type-id";

            var lowerType = new TypeIndexerStub(typeId.ToLower());
            var upperType = new TypeIndexerStub(typeId.ToUpper());

            var upperFilterFunc = Type.ToFunc(typeId.ToUpper());
            Assert.IsTrue(upperFilterFunc(lowerType));
            Assert.IsTrue(upperFilterFunc(upperType));

            var lowerFilterFunc = Type.ToFunc(typeId.ToLower());
            Assert.IsTrue(lowerFilterFunc(lowerType));
            Assert.IsTrue(lowerFilterFunc(upperType));
        }

        [Test]
        public void PartialType()
        {
            var typeId = "type-id";

            var funcFilter = Type.ToFunc($"{typeId}");

            Assert.IsFalse(funcFilter(new TypeIndexerStub($"{typeId}suffix")));
            Assert.IsFalse(funcFilter(new TypeIndexerStub($"prefix{typeId}")));
            Assert.IsFalse(funcFilter(new TypeIndexerStub($"prefix{typeId}suffix")));
        }
    }


}
