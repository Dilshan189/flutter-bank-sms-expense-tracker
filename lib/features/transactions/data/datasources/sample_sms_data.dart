class SampleSmsData {
  static const List<String> pdfSampleMessages = [
    '''LKR 150.00 debited from AC **1111 via POS at KOTTAWA INTERCHANGE 10500302 28/03/2026 14:19:13 To Inq Call 0112303050 Get protected - Do not Share OTP''',
    '''LKR 1,692.00 debited from AC **1114 via POS at KEELLS SUPER - KOTTAWA 10402483 25/03/2026 17:46:49 To Inq Call 0112303050 Get protected - Do not Share OTP''',
    '''LKR 5,970.00 debited from AC **1114 via POS at P AND B FUEL MART 10000759 25/03/2026 18:58:40 To Inq Call 0112303050 Get protected - Do not Share OTP''',
  ];

  static const List<String> additionalSampleMessages = [
    '''LKR 125,000.00 credited to AC **1114 Salary Transfer 24/03/2026 09:30:00 To Inq Call 0112303050''',
    '''LKR 3,450.00 debited from AC **1111 via POS at CARGILLS FOOD CITY - MAHARAGAMA 10203040 22/03/2026 19:15:22 To Inq Call 0112303050''',
    '''LKR 1,200.00 debited from AC **1114 via POS at JAVA LOUNGE 10998877 20/03/2026 11:40:10 To Inq Call 0112303050''',
  ];

  static List<String> get allSampleMessages => [
        ...pdfSampleMessages,
        ...additionalSampleMessages,
      ];
}
