import unittest

from jysmol import Jysmol

class TestStringify(unittest.TestCase):

    def test_string(self):
        data = "oke"
        self.assertEqual(Jysmol.parse(Jysmol.stringify(data)), data)

    def test_positive_int(self):
        data = 1234
        self.assertEqual(Jysmol.parse(Jysmol.stringify(data)), data)

    def test_negative_int(self):
        data = -1234
        self.assertEqual(Jysmol.parse(Jysmol.stringify(data)), data)

    def test_positive_float(self):
        data = 1234.234
        self.assertEqual(Jysmol.parse(Jysmol.stringify(data)), data)

    def test_negative_float(self):
        data = -1234.234
        self.assertEqual(Jysmol.parse(Jysmol.stringify(data)), data)

    def test_object(self):
        data = {"key1": "okeh", "key2": 1234 }
        self.assertEqual(Jysmol.parse(Jysmol.stringify(data)), data)

    def test_array(self):
        data = [{"key1": "value", "key2": 1234, "key3": [1,2,3], "key4": {}}]
        self.assertEqual(Jysmol.parse(Jysmol.stringify(data)), data)

    def test_null(self):
        data = None
        self.assertEqual(Jysmol.parse(Jysmol.stringify(data)), data)

    def test_true(self):
        data = True
        self.assertEqual(Jysmol.parse(Jysmol.stringify(data)), data)

    def test_false(self):
        data = False
        self.assertEqual(Jysmol.parse(Jysmol.stringify(data)), data)

    def test_circuler_reference_array(self):
        data = []
        data.append(data)
        with self.assertRaises(Exception) as context:
            Jysmol.stringify(data)

        self.assertEqual(str(context.exception), 'circular reference')

    def test_circuler_reference_object(self):
        data = {}
        data['cir'] = data
        with self.assertRaises(Exception) as context:
            Jysmol.stringify(data)

        self.assertEqual(str(context.exception), 'circular reference')

if __name__ == '__main__':
    unittest.main()
