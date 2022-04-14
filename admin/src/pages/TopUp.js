import { useState, useEffect } from "react";
import Paper from "@mui/material/Paper";
import axios from "axios";
import moment from "moment";

import { url } from "../api";
// material
import {
  Card,
  Table,
  Stack,
  Button,
  TableRow,
  TableBody,
  TableCell,
  Container,
  Typography,
  TableContainer,
  TablePagination,
  TableHead,
  Alert,
  Collapse,
} from "@mui/material";
// components
import Page from "../components/Page";
import Scrollbar from "../components/Scrollbar";
import { Box } from "@mui/system";

export default function TopUp() {
  const [page, setPage] = useState(0);
  const [alert, setAlert] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(5);
  const [rows, setRows] = useState([]);
  const [open, setOpen] = useState(true);

  const getAllTopUpRequest = async () => {
    const response = await axios.get(url + "/admin/top-up/request");
    setRows(response.data.data);
  };

  const approveTopUp = async (id) => {
    axios.patch(url + `/admin/top-up/${id}`);
    window.location.reload();
  };

  // const approveTopUp = async (id) => {
  //   const response = axios.patch(url + `/admin/top-up/${id}`);
  //   console.log(response.data);
  //   if (response.data.Status === "completed") {
  //     alert("Top up saldo di-approve");
  //     window.location.reload();
  //   }
  // };
  // const isInitialMount = useRef(true);

  // useEffect(() => {
  //   if (isInitialMount.current) {
  //     isInitialMount.current = false;
  //   } else {
  //     return getAllTopUpRequest();
  //   }
  // }, [rows]);

  useEffect(() => {
    getAllTopUpRequest();
  }, []);

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };
  const emptyRows =
    rowsPerPage - Math.min(rowsPerPage, rows.length - page * rowsPerPage);

  return (
    <Page title="Top Up | Cakrawala.id Admin">
      <Container>
        <Stack
          direction="row"
          alignItems="center"
          justifyContent="space-between"
          mb={5}
        >
          <Typography variant="h4" gutterBottom>
            Top Up
          </Typography>
        </Stack>

        <Card>
          <Scrollbar>
            <TableContainer component={Paper}>
              <Table aria-label="simple table">
                <TableHead>
                  <TableRow>
                    <TableCell align="center">ID Transaksi</TableCell>
                    <TableCell align="center">ID User</TableCell>
                    <TableCell align="center">Nama</TableCell>
                    <TableCell align="center">Amount</TableCell>
                    <TableCell align="center">EXP</TableCell>
                    <TableCell align="center">Status</TableCell>
                    <TableCell align="center">Tanggal Request</TableCell>
                    <TableCell align="center">Action</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {rows.length <= 0 ? (
                    <TableCell colSpan={8} align="center">
                      Tidak ada top up request
                    </TableCell>
                  ) : (
                    rows
                      .slice(
                        page * rowsPerPage,
                        page * rowsPerPage + rowsPerPage
                      )
                      .map((row, index) => (
                        <TableRow key={row?.id}>
                          <TableCell align="center">{row?.id}</TableCell>
                          <TableCell align="center">{row?.UserID}</TableCell>
                          <TableCell align="center">
                            {row?.User?.Name}
                          </TableCell>
                          <TableCell align="center">{row?.Amount}</TableCell>
                          <TableCell align="center">{row?.Exp}</TableCell>
                          <TableCell align="center">{row?.Status}</TableCell>
                          <TableCell align="center">
                            {moment(row?.createdAt).format(
                              "MMMM Do YYYY, HH:mm:ss"
                            )}
                          </TableCell>
                          <TableCell align="center">
                            <Button
                              variant="outlined"
                              style={{
                                borderColor: "#00A2ED",
                                color: "#00A2ED",
                              }}
                              onClick={() => approveTopUp(row?.id)}
                            >
                              Approve
                            </Button>
                          </TableCell>
                        </TableRow>
                      ))
                  )}
                  {emptyRows > 0 && (
                    <TableRow style={{ height: 53 * emptyRows }}>
                      <TableCell colSpan={6} />
                    </TableRow>
                  )}
                </TableBody>
              </Table>
              <TablePagination
                rowsPerPageOptions={[5, 10, 25]}
                component="div"
                count={rows.length}
                rowsPerPage={rowsPerPage}
                page={page}
                onChangePage={handleChangePage}
                onChangeRowsPerPage={handleChangeRowsPerPage}
              />
            </TableContainer>
          </Scrollbar>
        </Card>
      </Container>
    </Page>
  );
}
