import unittest

from jysmol import Jysmol

class TestParser(unittest.TestCase):

    def test_string(self):
        self.assertEqual(Jysmol.parse('"okej"'), "okej")

    def test_positive_int(self):
        self.assertEqual(Jysmol.parse('1234'), 1234)

    def test_negative_int(self):
        self.assertEqual(Jysmol.parse('-1234'), -1234)

    def test_positive_float(self):
        self.assertEqual(Jysmol.parse('1234.1234'), 1234.1234)

    def test_negative_float(self):
        self.assertEqual(Jysmol.parse('-1234.1234'), -1234.1234)

    def test_null(self):
        self.assertEqual(Jysmol.parse('null'), None)

    def test_true(self):
        self.assertEqual(Jysmol.parse('true'), True)

    def test_false(self):
        self.assertEqual(Jysmol.parse('false'), False)

    def test_array(self):
        self.assertEqual(Jysmol.parse('["i1",{"key": "value",}, 1234,]'), ["i1", {"key": "value",}, 1234])

    def test_object(self):
        self.assertEqual(Jysmol.parse('{"k1": {}, "k2": 1234, "k3": "ok", "k4": [],}'), {"k1": {}, "k2": 1234, "k3": "ok","k4": []})

if __name__ == '__main__':
    unittest.main()
